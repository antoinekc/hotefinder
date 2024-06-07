module MissionsHelper
  def paris_zip_codes
    (75001..75020).map { |zip_code| ["750#{zip_code.to_s.rjust(2, '0')}", zip_code] }
  end
end