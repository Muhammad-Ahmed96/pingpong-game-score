module ApplicationHelper
  def getName(u)
    name = u.name.to_s.length == 0 ? u.email.split("@").first : u.name rescue "¯\_(ツ)_/¯"
    name.titleize
  end
end
