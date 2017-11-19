##################################################
# Copyright (C) 2017, All rights reserved.
##################################################

def domain_file_path(s):
    return "/".join(reversed(s.split(".")))

def reversed_domain(s):
    return ".".join(reversed(s.split(".")))
