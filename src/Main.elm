module Main exposing (..)

<<<<<<< 743da94aece469ed0bb4d979f1f81125e44fcf59
import View exposing (view)
import State exposing (init, update, subscriptions)
import Types exposing (Model, Msg(..))
=======
import App.View exposing (view)
import App.State exposing (init, update, subscriptions)
import App.Type exposing (Model, Msg(..))
>>>>>>> App module, initial login and logout feature
import Navigation exposing (program)


main : Program Never Model Msg
main =
    program OnLocationChange
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
