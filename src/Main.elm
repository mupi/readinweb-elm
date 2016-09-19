module Main exposing (..)

import Html.App as Html
import View exposing (view)
import State exposing (init, update)


main : Program Never
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
