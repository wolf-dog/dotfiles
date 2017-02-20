function fish_user_key_bindings
  bind \cd ''

  ### fzf ###
  bind \ct '__fzf_find_file'
  bind \cr '__fzf_reverse_isearch'
  bind \cx '__fzf_find_and_execute'
  bind \ed '__fzf_cd'
  bind \eD '__fzf_cd_with_hidden'
  if bind -M insert >/dev/null ^/dev/null
      bind -M insert \ct '__fzf_find_file'
      bind -M insert \cr '__fzf_reverse_isearch'
      bind -M insert \cx '__fzf_find_and_execute'
      bind -M insert \ed '__fzf_cd'
      bind -M insert \eD '__fzf_cd_with_hidden'
  end
  ### fzf ###
end

fzf_key_bindings
