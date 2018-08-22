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
defmodule AutoApi.ParkingBrakeState do
  @moduledoc """
  ParkingBrake state
  """

  alias AutoApi.CommonData
  defstruct parking_brake: nil, timestamp: nil, properties: []

  use AutoApi.State, spec_file: "specs/parking_brake.json"

  @type activity :: :inactive | :active

  @type t :: %__MODULE__{
          parking_brake: activity | nil,
          timestamp: DateTime.t() | nil,
          properties: list(atom)
        }

  @doc """
  Build state based on binary value

    iex> AutoApi.ParkingBrakeState.from_bin(<<0x01, 1::integer-16, 0x00>>)
    %AutoApi.ParkingBrakeState{parking_brake: :inactive}

    iex> AutoApi.ParkingBrakeState.from_bin(<<0x01, 1::integer-16, 0x01>>)
    %AutoApi.ParkingBrakeState{parking_brake: :active}

  """
  @spec from_bin(binary) :: __MODULE__.t()
  def from_bin(bin) do
    parse_bin_properties(bin, %__MODULE__{})
  end

  @doc """
  Parse state to bin
    iex> AutoApi.ParkingBrakeState.to_bin(%AutoApi.ParkingBrakeState{parking_brake: :inactive, properties: [:parking_brake]})
    <<1, 1::integer-16, 0>>

    iex> AutoApi.ParkingBrakeState.to_bin(%AutoApi.ParkingBrakeState{parking_brake: :active, properties: [:parking_brake]})
    <<1, 1::integer-16, 1>>
  """
  @spec to_bin(__MODULE__.t()) :: binary
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end