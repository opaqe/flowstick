module XPDL.Activity exposing (Activities, Activity, ActivityId, activitiesFromJson)

import XPDL.Lane exposing (LaneId)
import XPDL.Extra exposing (createDict, find)
import Dict exposing (Dict)
import Json.XPDL.Package exposing (Package)
import Json.XPDL.Activity as JAct


type alias Activity =
    { id : ActivityId
    , name : Maybe String
    , lane : LaneId
    , x : Int
    , y : Int
    }


type alias ActivityId =
    String


type alias Activities =
    Dict ActivityId Activity


activityFromJson : JAct.Activity -> Activity
activityFromJson act =
    let
        graphicsInfo =
            act.graphicsInfo
    in
        { id = act.id
        , name = act.name
        , lane = graphicsInfo.lane
        , x = graphicsInfo.x
        , y = graphicsInfo.y
        }


activitiesFromJson : Package -> Activities
activitiesFromJson package =
    let
        allActs =
            List.concatMap (.activities) package.processes
    in
        createDict (.id) activityFromJson allActs