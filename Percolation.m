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
## @deftypefn {} {@var{retval} =} Percolation (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Mathieu Perriot <mathieuperriot@pmacigmens-DR>
## Created: 2025-02-02

function [Proba_OD_decrease, Proba_ARC_removal, Critical_percolation_threshold] = Percolation(Qtriu, Adj, OD)
    Adj_updated = Adj;
    OD_updated = OD;
    edges = find(Qtriu ~= Inf);
    [~, sorted_idx] = sort(Qtriu(edges), 'ascend');
    edges = edges(sorted_idx);

    total_OD = sum(OD(:));
    Proba_OD_decrease = [];
    Proba_ARC_removal = [];

    for k = 1:length(edges)
        [i, j] = ind2sub(size(Qtriu), edges(k));
        Adj_updated(i, j) = 0;
        Adj_updated(j,i) = 0;

        [OD_updated, disconnected] = updateOD(OD, Adj_updated);

        remaining_OD = sum(OD_updated(:));
        Proba_ARC_removal(end+1) = k / length(edges);
        Proba_OD_decrease(end+1) = remaining_OD / total_OD;

        if disconnected && (exist("Critical_percolation_threshold", "var") == 0) % little hack
            Critical_percolation_threshold = k / length(edges)
        end
    end
end

