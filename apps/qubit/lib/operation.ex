defmodule Operation do
  @moduledoc """
  Documentation for `Operation`.
  """

  def read(qubit) do
    mag =
      Qubit.zero_magnitude(qubit)
      |> Kernel.*(100)
      |> IO.inspect()
      |> floor()

    Qubit.put(qubit, :collapsed, true)

    case :rand.uniform(100) <= mag do
      true ->
        write(qubit, 1)
        |> Qubit.bracket()
        |> IO.inspect()

      false ->
        write(qubit, 0)
        |> Qubit.bracket()
        |> IO.inspect()
    end

    qubit
  end

  def write(qubit, mag) do
    Qubit.put(qubit, :magnitude, mag)

    qubit
  end

  def nott(qubit) do
    zero_mag = Qubit.zero_magnitude(qubit)

    new_zero =
      (1.0 - zero_mag)
      |> Float.round(2)

    Qubit.put(qubit, :magnitude, new_zero)

    qubit
  end

  def hadamard(qubit) do
    # TODO
    Qubit.zero_magnitude(qubit)
    |> case do
         0.5 ->
           prev = Qubit.get(qubit, :had_prev)
           Qubit.put(qubit, :magnitude, prev)

         zero_mag ->
           Qubit.put(qubit, :had_prev, zero_mag)
           Qubit.put(qubit, :magnitude, 0.5)
       end

    qubit
  end

  def phase(qubit) do
    # TODO
    qubit
  end

  def rotx(qubit) do
    # TODO
    qubit
  end

  def roty(qubit) do
    # TODO
    qubit
  end

  def rnot(qubit) do
    # TODO
    qubit
  end

  defdelegate had(qubit), to: __MODULE__, as: :hadamard
end
