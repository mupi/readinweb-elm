module Type exposing (..)

-- import HttpBuilder
-- My modules

import Register.Type as Register
import User.Type as User


type alias Model =
    { register : Register.Model
    , status : Status
    , user : User.Model
    }


type Status
    = Register
    | Login



--
-- type alias User =
--     { username : String
--     , name : String
--     , password : String
--     , email : String
--     , token : String
--     }


type Msg
    = ChangeStatus Status
    | RegisterMsg Register.Msg
    | LoginSuccess
