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
defmodule AutoApi.KeyfobPositionState do
  @moduledoc """
  KeyfobPosition state
  """

  alias AutoApi.PropertyComponent

  defstruct keyfob_position: nil,
            timestamp: nil,
            properties: [],
            property_timestamps: %{}

  use AutoApi.State, spec_file: "specs/keyfob_position.json"

  @type position ::
          :out_of_range
          | :outside_driver_side
          | :outside_in_front_of_car
          | :outside_passenger_side
          | :outside_behind_car
          | :inside_car

  @type t :: %__MODULE__{
          keyfob_position: %PropertyComponent{data: position} | nil,
          timestamp: DateTime.t() | nil,
          properties: list(atom),
          property_timestamps: map()
        }

  @doc """
  Build state based on binary value
  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(bin) do
    parse_bin_properties(bin, %__MODULE__{})
  end

  @doc """
  Parse state to bin
  """
  @spec to_bin(__MODULE__.t()) :: binary
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end
