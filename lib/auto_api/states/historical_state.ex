# AutoAPI
# Copyright (C) 2018 High-Mobility GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see http://www.gnu.org/licenses/.
#
# Please inquire about commercial licensing options at
# licensing@high-mobility.com
defmodule AutoApi.HistoricalState do
  @moduledoc """
  Historical state
  """

  alias AutoApi.{CommonData, PropertyComponent}

  defstruct states: [],
            capability_id: nil,
            start_date: nil,
            end_date: nil,
            timestamp: nil

  use AutoApi.State, spec_file: "specs/historical.json"

  @type t :: %__MODULE__{
          states: list(%PropertyComponent{}),
          capability_id: %PropertyComponent{data: integer} | nil,
          start_date: %PropertyComponent{data: DateTime.t()} | nil,
          end_date: %PropertyComponent{data: DateTime.t()} | nil,
          timestamp: DateTime.t() | nil
        }

  @doc """
  Build state based on binary value

    iex> AutoApi.HistoricalState.from_bin(<<2, 5::integer-16, 1, 2::integer-16, 0x00, 0x60>>)
    %AutoApi.HistoricalState{capability_id: %AutoApi.PropertyComponent{data: 0x60}}
  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(bin) do
    parse_bin_properties(bin, %__MODULE__{})
  end

  @doc """
  Parse state to bin

    iex> state = %AutoApi.HistoricalState{capability_id: %AutoApi.PropertyComponent{data: 0x60}}
    iex> AutoApi.HistoricalState.to_bin(state)
    <<2, 5::integer-16, 1, 2::integer-16, 0x00, 0x60>>
  """
  @spec to_bin(__MODULE__.t()) :: binary
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end