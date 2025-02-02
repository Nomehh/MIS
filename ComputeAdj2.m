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
## @deftypefn {} {@var{retval} =} ComputeAdj2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Mathieu Perriot <mathieuperriot@pmacigmens-DR>
## Created: 2025-01-31

function [Adj,wAdj]=ComputeAdj2(ROUTES,TravelLinkTime, StopList)

  Stoplist=StopList;
  sizeAdj=ComputeSizeAdj(ROUTES);
  Adj = zeros(sizeAdj,sizeAdj); wAdj= zeros(sizeAdj);

  for itinerary = 1:size(ROUTES,2)
    [LastStopIdx,Stoplist] = SearchIndex(Stoplist,ROUTES{itinerary}{1});
    for Stop = 2:size(ROUTES{itinerary},2)
      [StopIdx,Stoplist] = SearchIndex(Stoplist,ROUTES{itinerary}{Stop});
      Adj(LastStopIdx,StopIdx) = 1;
      wAdj(LastStopIdx,StopIdx) = TravelLinkTime{itinerary}{Stop-1};
      LastStopIdx=StopIdx;
    end
  end
end

