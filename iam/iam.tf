resource "aws_iam_user" "esantosUser" {
    name = "esantosUser"
}

resource "aws_iam_group" "esantosGroup" {
  name = "esantosGroup"
}

resource "aws_iam_user_policy_attachment" "userAttachment" {
  user       = aws_iam_user.esantosUser.name
  policy_arn = "arn:aws:iam::785262463656:policy/PowerUser"
}

resource "aws_iam_group_policy_attachment" "groupAttachment" {
  group      = aws_iam_group.esantosGroup.name
  policy_arn = "arn:aws:iam::785262463656:policy/PowerUser"
}