defmodule Operation do
  @moduledoc """
  Documentation for `Operation`.
  """

  def read(qubit) do

  end

  def write(qubit) do

  end

  def nott(qubit) do

  end

  def hadamard(qubit) do

  end

  def phase(qubit) do

  end

  def rotx(qubit) do

  end

  def roty(qubit) do

  end

  def rnot(qubit) do

  end

  defdelegate had(qubit), to: __MODULE__, as: :hadamard
end
