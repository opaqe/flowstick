module Header.View exposing (header, headerClasses)

import Header.Styles exposing (Class(..), namespaceId)
import History exposing (History)
import Html exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Html.Events exposing (onClick)
import State exposing (Model, Msg(FileMsg, Undo, Redo))
import Styles.Icons exposing (IconSize(Small), icon)
import Styles.Namespace exposing (FlowstickNamespace)
import Xpdl.File exposing (Msg(..))


ns : FlowstickNamespace Header.Styles.Class id State.Msg
ns =
    withNamespace namespaceId


headerClasses : Attribute State.Msg
headerClasses =
    ns.class [ Header ]


buttons : History Model -> Html State.Msg
buttons history =
    let
        undoAttrs =
            if List.isEmpty history.past then
                [ ns.class [ DisabledButton ] ]
            else
                [ onClick Undo ]

        redoAttrs =
            if List.isEmpty history.future then
                [ ns.class [ DisabledButton ] ]
            else
                [ onClick Redo ]
    in
        ul []
            [ li [ onClick <| FileMsg OpenFileDialog ] [ icon "folder open" Small ]
            , li undoAttrs [ icon "undo" Small ]
            , li redoAttrs [ icon "redo" Small ]
            ]


titleAndControls : History Model -> Html State.Msg
titleAndControls history =
    div [ ns.class [ TitleAndControls ] ]
        [ h1 [] [ text "Flowstick" ]
        , buttons history
        ]


searchBar : Html State.Msg
searchBar =
    div [ ns.class [ SearchBar ] ] [ text "" ]


header : History Model -> List (Html State.Msg)
header history =
    [ titleAndControls history
    , searchBar
    ]
