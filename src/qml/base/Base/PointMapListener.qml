/*
    Copyright (C) 2017 Aseman Team
    http://aseman.co

    AsemanQtTools is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    AsemanQtTools is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0

QtObject {
    property Item source
    property Item dest
    property real x: 0
    property real y: 0

    readonly property point result: {
        var prnt = source
        var rX=0, rY=0;
        while(prnt != dest) {
            if(!prnt) return Qt.point(-1, -1)
            rX += prnt.x
            rY += prnt.y
            prnt = prnt.parent
        }

        return Qt.point(rX+x, rY+y)
    }
}
