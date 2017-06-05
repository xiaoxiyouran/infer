(*
 * Copyright (c) 2016 - present Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *)

open! IStd

module type Kind = sig
  include TraceElem.Kind

  (** return the parameter index and sink kind for the given call site with the given actuals *)
  val get : Typ.Procname.t -> HilExp.t list -> Tenv.t -> (t * int) list
end

module type S = sig
  include TraceElem.S

  type parameter =
    {
      sink : t;
      (** sink type of the parameter *)
      index : int;
      (** index of the parameter *)
    }

  (** return the parameter index and sink kind for the given call site with the given actuals *)
  val get : CallSite.t -> HilExp.t list -> Tenv.t -> parameter list
end

module Make (Kind : Kind) : S with module Kind = Kind