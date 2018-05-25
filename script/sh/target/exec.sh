#!/bin/bash
export PERL_MM_USE_DEFAULT=1
perl -MCPAN -e 'install YAML::XS;'
perl -MCPAN -e 'install File::Copy::Recursive;'
perl -MCPAN -e 'install File::Remove;'
perl -MCPAN -e 'install Net::Address::IP::Local;'
perl -MCPAN -e 'install IPC::System::Simple;'
perl -MCPAN -e 'install XML::SimpleObject::LibXML;'
perl -MCPAN -e 'install Switch;'
read -p "Appuyez sur [Entree] pour continuer..."
