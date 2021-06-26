defmodule Qubit do
  @moduledoc """
  Documentation for `Qubit`.

  qubits have a bit of info
  magnitude: single float representing the |0> value, |1> value derived
  phase
  entangled
  """
  def start_link() do
    mag =
      :rand.uniform()
      |> Float.round(2)

    phase = {0, 0}
    state = %{magnitude: mag, phase: phase, entangled: [], had_prev: mag, collapsed: false}

    {:ok, qubit} = Agent.start_link(fn -> state end)

    qubit
  end

  # Basic elixir specific utitlies

  @doc """
  Gets a value from the `qubit` by `key`.
  """
  def get(qubit, key) do
    Agent.get(qubit, &Map.get(&1, key))
  end

  @doc """
  Puts the `value` for the given `key` in the `qubit`.
  """
  def put(qubit, key, value) do
    Agent.update(qubit, &Map.put(&1, key, value))
  end

  # Quantum related tooling
  @doc """
  Entangle two qubits
  """
  def entangle(q1, q2) do
    q1_new_ent =
      [q2 | get(q1, :entangled)]
      |> Enum.uniq()

    put(q1, :entangled, q1_new_ent)

    q2_new_ent =
      [q1 | get(q2, :entangled)]
      |> Enum.uniq()

    put(q2, :spin, get(q1, :spin))
    put(q2, :entangled, q2_new_ent)
  end

  @doc """
  List a qubits entanglements
  """
  def entangled_qubits(agent) do
    Agent.get(agent, &Map.get(&1, :entangled))
  end

  @doc """
  Violtate physics take a magnitude measure without collapse!
  """
  def zero_magnitude(agent) do
    Agent.get(agent, &Map.get(&1, :magnitude))
  end

  @doc """
  Boolean return for if a qubit is entangled or not
  """
  def entangled?(agent) do
    entangled_qubits(agent)
    |> Enum.any?()
  end

  @doc """
  Inform a qubits entangled relations of a state change
  """
  def inform_entangled(agent) do
    entangled_qubits(agent)
    |> Enum.each(fn q -> q end)
  end

  @doc """
  Violate the known laws of physics and
  see the current state of a qubit
  """
  def bracket(agent) do
    zero_mag = zero_magnitude(agent)

    one_mag =
      (1.0 - zero_mag)
      |> Float.round(2)

    "|#{zero_mag}>  |#{one_mag}>"
  end

  @doc """
  Get the value for the phase of |0>
  """
  def zero_phase(agent) do
    {z, o} = Agent.get(agent, &Map.get(&1, :phase))
    o
  end

  @doc """
  Get the value for the phase of |1>
  """
  def one_phase(agent) do
    {z, o} = Agent.get(agent, &Map.get(&1, :phase))
    z
  end
end
