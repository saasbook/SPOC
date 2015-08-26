Course = Struct.new('Course',:title, :institution, :id, :date, :contact) do
  def url
    "https://studio.edge.edx.org/course/#{institution}/#{id}/#{date}/"
  end
  def team_url
    "https://studio.edge.edx.org/course_team/course-v1:#{institution}+#{id}+#{date}"
  end
end

