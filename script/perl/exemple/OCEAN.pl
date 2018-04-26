#!/usr/bin/perl -w

#
# OCEAN : a THETYS process's configuration file generator
# Copyright (C) 2015-2016 Nawfel KINANI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program; see the files COPYING and COPYING.LESSER.
# If not, see <http://www.gnu.org/licenses/>.
#

# perl version
use 5.024;

# force declaration, warnings & print error diagnostics
use strict;
use warnings;
use diagnostics;

# package usage section
use lib qw(module);
use Ocean::procedure;

# ------------------------------
# OCEAN script
# ------------------------------
# auteur : 	Nawfel Kinani
# création: 23/02/15
# groupe : 	Onera DCSD/PSEV LabSim
#

# ==================================================================================================================
# 											Flux d'execution principal
# ==================================================================================================================

# Doin'it easy
sub Run() {
	Ocean::procedure::PreConfigure();	# OCEAN << argumement line parsing << configure settings, make tmp & import basic templates
	Ocean::procedure::Parse();			# OCEAN << IN files (tmp)
	Ocean::procedure::Stage();			# OCEAN >> OUT files (tmp)
	Ocean::procedure::Scale();			# OCEAN >> system wide scaling from tmp
	Ocean::procedure::PostConfigure();	# OCEAN >> delete & clean
}

# DUMMMB :)
Run();
