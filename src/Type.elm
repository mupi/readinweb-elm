module Type exposing (..)

-- My modules

import Register.Type as Register
import User.Type as User
import Login.Type as Login


type alias Model =
    { register : Register.Model
    , login : Login.Model
    , status : Status
    , user : User.Model
    }


type Status
    = Register
    | About
    | Login
    | Index


type Msg
    = ChangeStatus Status
    | RegisterMsg Register.Msg
    | LoginMsg Login.Msg
    | LoginSuccess
    | LoadToken (Maybe String)
    | SaveToken
