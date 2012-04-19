module IssuesHelper
  def split_main_issues
    @main_issues = MainIssue.order('name ASC')

    count = MainIssue.count
    split_count = count / 3

    x1 = 0
    y1 = split_count - 1
    x2 = split_count
    y2 = (split_count * 2) - 1
    x3 = split_count * 2
    y3 = (split_count * 3)

    @row1 = @main_issues[x1..y1]
    @row2 = @main_issues[x2..y2]
    @row3 = @main_issues[x3..y3]
  end
end
