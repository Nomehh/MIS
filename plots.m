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
## @deftypefn {} {@var{retval} =} plots (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Mathieu Perriot <mathieuperriot@pmacigmens-DR>
## Created: 2025-02-02

function plots(Q1, Q2, Q3, Adj, OD)
    % Scénario (a) : Based on TT
    Qtriu1 = Q1 .* (tril(Inf(size(Q1))) + 1);
    [Proba_OD1, Proba_ARC1, Critical1] = Percolation(Qtriu1, Adj, OD);
    alpha_a = manual_integration(Proba_OD1, Proba_ARC1)

    % Scénario (b) : Inverse of (a)
    Qtriu2 = Q2 .* (tril(Inf(size(Q2))) + 1);
    [Proba_OD2, Proba_ARC2, Critical2] = Percolation(Qtriu2, Adj, OD);
    alpha_b = manual_integration(Proba_OD2, Proba_ARC2)

    % Scénario (c) : Based on BC
    Qtriu3 = Q3 .* (tril(Inf(size(Q3))) + 1);
    [Proba_OD3, Proba_ARC3, Critical3] = Percolation(Qtriu3, Adj, OD);
    alpha_c = manual_integration(Proba_OD3, Proba_ARC3)

    figure;
    hold on;
    plot(Proba_ARC1, Proba_OD1, 'r-', 'LineWidth', 2);
    plot(Proba_ARC2, Proba_OD2, 'b--', 'LineWidth', 2);
    plot(Proba_ARC3, Proba_OD3, 'g-.', 'LineWidth', 2);

    plot(Critical1, interp1(Proba_ARC1, Proba_OD1, Critical1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    plot(Critical2, interp1(Proba_ARC2, Proba_OD2, Critical2), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
    plot(Critical3, interp1(Proba_ARC3, Proba_OD3, Critical3), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');

    xlabel('Proportion of Removed Edges');
    ylabel('Proportion of Remaining OD Demand');
    legend('Scenario (a): Inverse Travel Time', ...
           'Scenario (b): Reverse Order', ...
           'Scenario (c): Edge Betweenness Centrality', ...
           'Location', 'southwest');
    title('Percolation Analysis for Different Quality Matrices');
    grid on;
    hold off;
end

