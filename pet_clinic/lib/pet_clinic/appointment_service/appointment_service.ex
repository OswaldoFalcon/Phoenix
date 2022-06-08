defmodule PetClinic.AppointmentService.AppointmentService do
  @moduledoc """
  The AppointmentService Module checks if is a Available Appoinment slot 
  for a specefic Healt Expert.  
  """
  alias PetClinic.Repo
  alias PetClinic.PetClinicService.Pet
  alias PetClinic.AppointmentService.Appointment
  alias PetClinic.AppointmentService.ExpertSchedule
  import Ecto.Query

  def available_slots(id, from_date, to_date) do
    cond do
      # Compara la fecha  #AppointmentService.available_slots(2,~D[2022-05-26], ~D[2022-05-25])#
      Date.compare(from_date, to_date) == :gt ->
        {:error, "wrong date range"}

      # Compara si  la fecha esta en el pasado , comparanado con fecha now   AppointmentService.available_slots(2,~D[2022-05-23], ~D[2022-05-25])
      Date.compare(from_date, NaiveDateTime.to_date(NaiveDateTime.utc_now())) == :lt ->
        {:error, "From datetime is in the past"}

      # Compara  AppointmentService.available_slots(2,~D[2022-05-26], ~D[2022-05-26])
      Date.compare(from_date, to_date) == :eq ->
        slots(id, from_date, to_date)

      # Compara  AppointmentService.available_slots(2,~D[2022-05-26], ~D[2022-05-31])
      Date.compare(from_date, to_date) == :lt ->
        slots(id, from_date, to_date)
    end
  end

  def new_appointmen(id_expert, id_pet, timedate) do
    date = NaiveDateTime.to_date(timedate)
    time = NaiveDateTime.to_time(timedate)
    # from_date =  NaiveDateTime.to_date(NaiveDateTime.utc_now)  
    # condicion para expert id#
    cond do
      Repo.get_by(ExpertSchedule, health_expert_id: id_expert) == nil ->
        {:error, "No expert id"}

      Repo.get_by(ExpertSchedule, health_expert_id: id_expert) != nil ->
        # condicion para saber si hay pet#
        cond do
          Repo.get_by(Pet, id: id_pet) == nil ->
            {:error, "No pet dont exist"}

          Repo.get_by(Pet, id: id_pet) != nil ->
            slots = available_slots(id_expert, date, date)

            slot_availability = is_there_slot(slots, date, time)
            # condicion para saber si esta disponible el slot #
            make_appointment(slot_availability, id_expert, id_pet, timedate)
        end
    end
  end

  # -----------------------------------------private-------------------------------------------__#

  defp slots(id, from_date, to_date) do
    expert = Repo.one(from e in ExpertSchedule, where: e.health_expert_id == ^id)
    range = date_range(from_date, to_date)
    days = transform_to_day(range)
    days_hours = schedule(expert, days)

    filter(days_hours, range)
    |> Enum.map(fn f -> %{Enum.at(f, 2) => [Enum.at(f, 0), Enum.at(f, 1)]} end)
    |> Enum.map(fn date -> time_range(date) end)
    |> List.flatten()
  end

  defp time_range(date) do
    Enum.map(date, fn {k, v} -> %{k => time_range(List.first(v), List.last(v))} end)
  end

  # Regreas un valor booleano si esta disponible o no el slot 
  defp is_there_slot(slots, date, time) do
    Enum.map(slots, fn slot ->
      slot[date]
      |> Enum.map(fn hour -> Time.truncate(hour, :second) end)
      |> Enum.member?(time)
    end)
    |> Enum.member?(true)
  end

  # hace un appoinment  
  defp make_appointment(is_there, id_expert, id_pet, timedate) do
    cond do
      is_there == true ->
        chset = %Appointment{health_expert_id: id_expert, pet_id: id_pet, date: timedate}
        {status, _} = Repo.insert(chset)
        {status, "Add New Appoinment"}

      is_there == false ->
        {:error, "NO hour for this day"}
    end
  end

  # toma 2 fehcas y regresa un LISTA DE FECHAS
  defp date_range(from_date, to_date) do
    range = Date.range(from_date, to_date)
    Enum.take(range, Enum.count(range))
  end

  # toma el dato tipo date y busca su dia de la semana
  defp transform_to_day(range) do
    Enum.map(range, fn date -> Date.day_of_week(date) end)
  end

  # Busca en el Struct los horarios
  defp schedule(expert, days) do
    Enum.map(days, fn day ->
      cond do
        day == 1 -> [expert.monday_start, expert.monday_end]
        day == 2 -> [expert.tuesday_start, expert.tuesday_end]
        day == 3 -> [expert.wednesday_start, expert.wednesday_end]
        day == 4 -> [expert.thursday_start, expert.thursday_end]
        day == 5 -> [expert.friday_start, expert.friday_end]
        day == 6 -> [expert.saturday_start, expert.saturday_end]
        day == 7 -> [expert.sunday_start, expert.sunday_end]
      end
    end)
  end

  # Funcion recursiva para crear slots de media hora
  defp time_range(init_time, end_time) do
    case Time.compare(init_time, end_time) do
      # :gt ->
      #  []

      :eq ->
        [init_time]

      # recursion
      :lt ->
        rec = Time.add(init_time, 1800)
        [init_time | time_range(rec, end_time)]
    end
  end

  # Funcion para filtrar los slots con nil
  defp filter(schedule, range) do
    Enum.zip(schedule, range)
    |> Enum.map(fn t -> Tuple.to_list(t) end)
    |> List.flatten()
    |> Enum.chunk_every(3)
    |> Enum.map(fn x -> List.delete(x, nil) end)
    |> Enum.filter(fn x -> length(x) > 2 end)
  end

  # funcion poara convertir a map las listas 
  # def available(filter) do
  #  Enum.map(filter, fn f -> %{Enum.at(f, 2) => [Enum.at(f, 0), Enum.at(f, 1)]} end)
  #  |> Enum.map(fn date ->
  #    Enum.map(date, fn {k, v} -> %{k => time_range(List.first(v), List.last(v))} end)
  #  end)
  #  |> List.flatten()
  # end

  # funcion para consultar un appoinment
  def get_appoinments(id, date) do
    [yyyy, mm, dd] = String.split(date, "-")
    {:ok, date} = Date.from_iso8601("#{yyyy}-#{mm}-#{dd}")
    apo = Repo.all(from a in Appointment, where: a.health_expert_id == ^id) |> Repo.preload(:pet)
    Enum.filter(apo, fn a -> NaiveDateTime.to_date(a.date) == date end)
  end
end
