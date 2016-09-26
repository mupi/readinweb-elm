module Register.Type exposing (..)

import HttpBuilder


-- My Modules

import User.Type as User


type Msg
    = SetUsername String
    | SetEmail String
    | SetName String
    | SetPassword String
    | ClickRegisterUser
    | RegisterError (HttpBuilder.Error String)
    | RegisterSuccess (HttpBuilder.Response String)


type alias Model =
    { error : String
    , user : User.Model
    }
