## Copyright (C) 2025 Mathieu Perriot
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} updateOD (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Mathieu Perriot <mathieuperriot@pmacigmens-DR>
## Created: 2025-02-02

function [OD_updated, disconnected] = updateOD(OD, Adj_updated)
    N = size(Adj_updated, 1);
    OD_updated = zeros(size(OD));
    disconnected = false;

    for origin = 1:N
        [Weights, Paths] = Dijkstra2(Adj_updated, origin);

        for dest = 1:N
                if isinf(Weights(dest))
                    disconnected = true;
                else
                    OD_updated(origin, dest) = OD(origin, dest);

            end end end end
