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
## @deftypefn {} {@var{retval} =} Percolation2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Mathieu Perriot <mathieuperriot@pmacigmens-DR>
## Created: 2025-02-02

function [Proba_OD_decrease, Proba_NODE_removal, Critical_node] = Percolation2(Adj, OD, Node_order)

    Adj_updated = Adj;
    OD_updated = OD;
    N = size(Adj, 1);
    total_OD = sum(OD(:));
    Proba_OD_decrease = [1];
    Proba_NODE_removal = [0];
    Critical_node = NaN;

    for k = 1:length(Node_order)
        node = Node_order(k);

        Adj_updated(node, :) = 0;
        Adj_updated(:, node) = 0;

        [OD_updated, disconnected] = updateOD(OD, Adj_updated);

        remaining_OD = sum(OD_updated(:));
        Proba_NODE_removal(end+1) = k / length(Node_order);
        Proba_OD_decrease(end+1) = remaining_OD / total_OD;

        if disconnected && isnan(Critical_node)
            Critical_node = k / length(Node_order);
        end
    end
end

