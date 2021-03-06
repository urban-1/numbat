//
// Copyright (C) 2005 Georg Lutz, Institut fuer Telematik, University of Karlsruhe
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, see <http://www.gnu.org/licenses/>.
//

package numbat.mobility;

//
// Random Waypoint mobility model.
//
// The node moves in line segments. For each line segment, a random destination
// position (distributed uniformly over the playground) and a random speed
// is chosen. You can define a speed as a variate from which a new value
// will be drawn for each line segment; it is customary to specify it as
// uniform(minSpeed, maxSpeed). When the node reaches the target position,
// it waits for the time waitTime which can also be defined as a variate.
// After this time the the algorithm calculates a new random position, etc.
//
// This model was written by Georg Lutz (GeorgLutz AT gmx DOT de) for his
// diploma thesis "Effizientes Modell fuer Funkverbindungen in 4G-Netzen fuer
// OMNeT++" (Efficient model for radio links in 4G networks for OMNeT++)
// at Institut fuer Telematik, Universitaet Karlsruhe (Institute for
// Telematics, University Karlsruhe, Germany), 2005-06-21. Slightly modified
// by Andras Varga 2005.06.22.
//
// @author Georg Lutz
//
simple WiMaxRandomWPMobility like WiMaxBasicMobility
{
    parameters:
        string controlModuleName = default("channelControl");
        bool debug = default(false); // debug switch
        double x = default(-1); // start x coordinate (-1 = display string position, or random if it's missing)
        double y = default(-1); // start y coordinate (-1 = display string position, or random if it's missing)
        double updateInterval @unit("s") = default(0.1s);
        volatile double speed @unit("mps") = default(2mps); // use uniform(minSpeed, maxSpeed) or another distribution
        volatile double waitTime @unit("s"); // wait time between reaching a target and choosing a new one
        @display("i=block/cogwheel_s");
}
