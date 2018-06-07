clear all;clc;
s=input('please input a set of elements','s');
n=input('how many permutations?');
q=input('how many elements does a permutation have?');
s=strsplit(s);
allperm=findperm(s,q,[],{});
allperm2=findperm2(s,q,q,[],{},n);