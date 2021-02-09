defmodule Qubit do
  @moduledoc """
  Documentation for `Qubit`.
  """

  def start_link() do
    spin = Enum.random([0,1])

    Agent.start_link(fn -> %{spin: spin, entangled: [], collapsed: false} end)
  end

  @doc """
  Gets a value from the `qubit` by `key`.
  """
  def get(qubit, key) do
    Agent.get(qubit, &Map.get(&1, key))
  end

  @doc """
  Puts the `value` for the given `qubit` in the `bucket`.
  """
  def put(qubit, key, value) do
    Agent.update(qubit, &Map.put(&1, key, value))
  end

  def entangle(q1, q2) do
    q1_new_ent = [q2| get(q1, :entangled)]
    |> Enum.uniq()

    put(q1, :entangled, q1_new_ent)

    q2_new_ent = [q1| get(q2, :entangled)]
    |> Enum.uniq()

    put(q2, :spin, get(q1, :spin))
    put(q2, :entangled, q2_new_ent)
  end

  def entangled_qubits(agent) do
    Agent.get(agent, &Map.get(&1, :entangled) )
  end

  def entangled?(agent) do
    entangled_qubits(agent)
    |> Enum.any?()
  end

  def inform_entangled(agent) do
    entangled_qubits(agent)
    |> Enum.each(fn q -> q end)
  end
end
