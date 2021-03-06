%% Copyright (c) 2009-2015, Michael Santos <michael.santos@gmail.com>
%% All rights reserved.
%%
%% Redistribution and use in source and binary forms, with or without
%% modification, are permitted provided that the following conditions
%% are met:
%%
%% Redistributions of source code must retain the above copyright
%% notice, this list of conditions and the following disclaimer.
%%
%% Redistributions in binary form must reproduce the above copyright
%% notice, this list of conditions and the following disclaimer in the
%% documentation and/or other materials provided with the distribution.
%%
%% Neither the name of the author nor the names of its contributors
%% may be used to endorse or promote products derived from this software
%% without specific prior written permission.
%%
%% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
%% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
%% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
%% FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
%% COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
%% INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
%% BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
%% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
%% LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
%% ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%% POSSIBILITY OF SUCH DAMAGE.
-module(pkt_gre).

-include("pkt_ether.hrl").
-include("pkt_gre.hrl").

-export([codec/1]).

codec(<<0:1,Res0:12,Ver:3,Type:16,Rest/binary>>) ->
    {#gre{c = 0, res0 = Res0, ver = Ver, type = Type
       },Rest
    };
codec(<<1:1,Res0:12,Ver:3,Type:16,Chksum:16,Res1:16,Rest/binary>>) ->
    {#gre{c = 1, res0 = Res0, ver = Ver, type = Type,
	chksum = Chksum, res1 = Res1
       },Rest
    };
codec(#gre{c = 0, res0 = Res0, ver = Ver, type = Type}) ->
    <<0:1,Res0:12,Ver:3,Type:16>>;
codec(#gre{c = 1, res0 = Res0, ver = Ver, type = Type,
	chksum = Chksum, res1 = Res1}) ->
    <<1:1,Res0:12,Ver:3,Type:16,Chksum:16,Res1:16>>.
