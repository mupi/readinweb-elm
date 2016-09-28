module Main exposing (..)

import Html.App as Html
import View exposing (view)
import State exposing (init, update, subscriptions)


main : Program Never
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
