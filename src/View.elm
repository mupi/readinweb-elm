module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- My Modules

import Type exposing (..)
import Login.View as Login


view : Model -> Html Msg
view model =
    div []
        [ Html.map LoginMsg (Login.view model.login)
        , text (toString model)
        ]
