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
## @deftypefn {} {@var{retval} =} manual_integration (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Mathieu Perriot <mathieuperriot@pmacigmens-DR>
## Created: 2025-02-02

function retval = manual_integration(Proba_OD_decrease, Proba_ARC_removal)

    Alpha_upper = 0;
    Alpha_lower = 0;

    for i = 1:length(Proba_ARC_removal) - 1
        delta_x = Proba_ARC_removal(i+1) - Proba_ARC_removal(i);
        y1 = Proba_OD_decrease(i);
        y2 = Proba_OD_decrease(i+1);

        Alpha_upper = Alpha_upper + max(y1, y2) * delta_x;
        Alpha_lower = Alpha_lower + min(y1, y2) * delta_x;
    end

    retval = (Alpha_upper + Alpha_lower) / 2;
end
