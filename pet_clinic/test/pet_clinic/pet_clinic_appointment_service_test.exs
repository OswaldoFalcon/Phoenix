defmodule PetClinic.AppointmentServiceTest do
  use PetClinic.DataCase
  alias PetClinic.AppointmentService.AppointmentService

  describe "appointments" do
    import PetClinic.AppointmentServiceFixtures

    test "When to date is less than from date" do
      schedule = expert_schedule_fixtures()
      id = schedule.health_expert_id

      assert {:error, "wrong date range"} ==
               AppointmentService.available_slots(id, ~D[2022-05-26], ~D[2022-05-25])
    end

    test "When from date is in the past" do
      schedule = expert_schedule_fixtures()
      id = schedule.health_expert_id

      assert {:error, "From datetime is in the past"} ==
               AppointmentService.available_slots(id, ~D[2022-05-23], ~D[2022-05-25])
    end

    test "When from date and to date are the same" do
      schedule = expert_schedule_fixtures()
      id = schedule.health_expert_id

      assert [%{~D[2022-05-30] => [~T[12:00:00], ~T[12:30:00.000000], ~T[13:00:00.000000]]}] ==
               AppointmentService.available_slots(id, ~D[2022-05-30], ~D[2022-05-30])

      # assert  {:error, "From datetime is in the past"}=
      #        AppointmentService.available_slots(id, ~D[2022-05-25], ~D[2022-05-25])
    end

    test "when from_date is less than to_date and are correct range" do
      schedule = expert_schedule_fixtures()
      id = schedule.health_expert_id

      assert [%{~D[2022-05-30] => [~T[12:00:00], ~T[12:30:00.000000], ~T[13:00:00.000000]]}] ==
               AppointmentService.available_slots(id, ~D[2022-05-26], ~D[2022-05-30])
    end

    test "no expert id" do
      appointment = appoinment_fixtures()
      pet_id = appointment.pet_id
      date = appointment.date
      assert {:error, "No expert id"} == AppointmentService.new_appointmen(30, pet_id, date)
    end

    test "Pet id dont exist" do
      appointment = appoinment_fixtures()
      schedule = expert_schedule_fixtures()
      expert_id = schedule.health_expert_id
      date = appointment.date

      assert {:error, "No pet dont exist"} ==
               AppointmentService.new_appointmen(expert_id, 0, date)
    end

    test "make appointment with no slot" do
      appointment = appoinment_fixtures()
      schedule = expert_schedule_fixtures()
      expert_id = schedule.health_expert_id
      pet_id = appointment.pet_id
      date = appointment.date

      assert {:error, "NO hour for this day"} ==
               AppointmentService.new_appointmen(expert_id, pet_id, date)
    end

    test "make appointment" do
      appointment = appoinment_fixtures()
      schedule = expert_schedule_fixtures()
      expert_id = schedule.health_expert_id
      pet_id = appointment.pet_id
      date = ~N[2022-05-30 13:00:00]

      assert {:ok, "Add New Appoinment"} ==
               AppointmentService.new_appointmen(expert_id, pet_id, date)
    end

    test "get appoinments for schedule" do
      appointment = appoinment_fixtures()
      id = appointment.health_expert_id
      date = "2022-05-31"
      assert [appointment] == AppointmentService.get_appoinments(id, date)
    end
  end
end
