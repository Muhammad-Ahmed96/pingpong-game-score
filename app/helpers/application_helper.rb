module ApplicationHelper
  def getName(u)
    u.name.to_s.length == 0 ? u.email.split("@").first : u.name
  end
end
