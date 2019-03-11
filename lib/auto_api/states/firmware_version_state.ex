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
defmodule AutoApi.FirmwareVersionState do
  @moduledoc """
  Keeps Firmware Version state

  """

  alias AutoApi.PropertyComponent

  @type car_sdk_version :: %PropertyComponent{
          data: %{
            version_major: integer,
            version_minor: integer,
            version_patch: integer
          }
        }

  @doc """
  Firmware Version state
  """
  defstruct car_sdk_version: nil,
            car_sdk_build_name: nil,
            application_version: nil,
            timestamp: nil,
            properties: [],
            property_timestamps: %{}

  use AutoApi.State, spec_file: "specs/firmware_version.json"

  @type t :: %__MODULE__{
          car_sdk_version: car_sdk_version | nil,
          car_sdk_build_name: %PropertyComponent{data: String.t()} | nil,
          application_version: %PropertyComponent{data: String.t()} | nil,
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

  @spec to_bin(__MODULE__.t()) :: binary
  @doc """
  Parse state to bin
  """
  def to_bin(%__MODULE__{} = state) do
    parse_state_properties(state)
  end
end
