module Login.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id, type_, for, value, class)
import Html.Events exposing (..)
import User.Type exposing (..)


-- import State exposing (..)


view : Model -> Html Msg
view model =
    div [ id "signup-form" ]
        [ Html.h1 [] [ text "User Details" ]
        , p [] [ text (toString model.id) ]
        , p [] [ text model.username ]
        , p [] [ text model.name ]
        , p [] [ text model.email ]
        , p [] [ text model.url ]
        , text (toString model)
        ]
