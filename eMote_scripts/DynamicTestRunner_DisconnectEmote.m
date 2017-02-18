% DynamicTestRunner_DisconnectEmote.m
% Michael Andrew McGrath <Michael.McGrath@Samraksh.com>
% 2014-11-20
% Script stops a running connection started by DynamicTestRunner_ConnectEmote.m

m_eng.Stop();
m_eng.Dispose();
clear m_eng;
