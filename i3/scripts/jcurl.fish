function jcurl
  #fish function to pretty print curl with less
  curl $argv | json | pygmentize -l json | less -R
end
