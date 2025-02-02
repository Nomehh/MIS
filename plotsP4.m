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
## @deftypefn {} {@var{retval} =} plotsP4 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Mathieu Perriot <mathieuperriot@pmacigmens-DR>
## Created: 2025-02-02

function plotsP4(Adj, OD)
    [~, Node_order_asc] = sort(BetweennessCentrality(Adj), 'ascend');
    [~, Node_order_desc] = sort(BetweennessCentrality(Adj), 'descend');

    [Proba_OD_asc, Proba_NODE_asc, Critical_node_asc] = Percolation2(Adj, OD, Node_order_asc);
    [Proba_OD_desc, Proba_NODE_desc, Critical_node_desc] = Percolation2(Adj, OD, Node_order_desc);
    proba_asc = Proba_OD_asc

    figure;
    hold on;

    plot(Proba_NODE_asc, Proba_OD_asc, 'b-', 'LineWidth', 2);
    plot(Proba_NODE_desc, Proba_OD_desc, 'r--', 'LineWidth', 2);

    plot(Critical_node_asc, interp1(Proba_NODE_asc, Proba_OD_asc, Critical_node_asc), ...
        'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
    plot(Critical_node_desc, interp1(Proba_NODE_desc, Proba_OD_desc, Critical_node_desc), ...
        'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

    xlabel('Proportion of Removed Nodes');
    ylabel('Proportion of Remaining OD Demand');
    title('Percolation Analysis Based on Node Removal');
    legend('Ascending Order (Least Important First)', 'Descending Order (Most Important First)', ...
           'Critical Threshold (Ascending)', 'Critical Threshold (Descending)', 'Location', 'southwest');
    grid on;
    hold off;
end

