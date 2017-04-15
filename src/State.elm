module State exposing (Model, Msg(..), Point, DragInfo(..))

import Json.Decode.Xpdl as JDX
import Xpdl.Activity exposing (ActivityId)
import Xpdl.File as File
import Xpdl.Process exposing (ProcessId)
import Xpdl.State as XS


type alias Point =
    ( Int, Int )


type Msg
    = JSONMsg JDX.Msg
    | FileMsg File.Msg
    | ChangeCurrentProcess ProcessId
    | DeselectAllActivities
    | SelectActivity ActivityId Point
    | StopDragging
    | Move Point
    | Undo
    | Redo


type DragInfo
    = NotDragging
    | Dragging
        { start : Point
        , diffX : Int
        , diffY : Int
        }


type alias Model =
    { xpdl : XS.XPDL
    , drag : DragInfo
    }
