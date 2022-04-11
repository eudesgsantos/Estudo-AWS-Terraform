output "DBSecGP"{
    value = "${aws_security_group.DBSecGP.id}"
}

output "EC2PubSecGP"{
    value = "${aws_security_group.EC2PubSecGP.id}"
}

output "EC2PrivSecGP"{
    value = "${aws_security_group.EC2PrivSecGP.id}"
}
