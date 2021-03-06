#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --prefix=dir      directory in which to install
  --include-subdir  include the Demo1-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the Demo1-1.0.1-Linux subdirectory
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Demo1 Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
LICENSE
=======

This is an installer created using CPack (http://www.cmake.org). No license provided.


____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Demo1 will be installed in:"
    echo "  \"${toplevel}/Demo1-1.0.1-Linux\""
    echo "Do you want to include the subdirectory Demo1-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Demo1-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

tail $use_new_tail_syntax +147 "$0" | gunzip | (cd "${toplevel}" && tar xf -) || cpack_echo_exit "Problem unpacking the Demo1-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� �!\ �Z}l[����N�&u���@K�F�)-ıS7ev�N��Y��t#�:�K�����&A��ш�uhb�BM����Ц�Q��T`@C�
�Z�����1�������Ia�iRN�w~��s��x�{ߍ���lLk��S��!�0���z��~s �{���>ŷ����j^�Z����5������ՍHBɤ�Ɨ��T.6���W*K���6��m�];:;Z{�=;���s�E�ඐڽe;F�OiJ��L��B=[;�lV����(%�:6��uCgɒ�F<\���֬^]��o�7�����5>?��M~_����m�ݡ���$�d}ai�<@� �W�m�U��R��2��z(`�S�5�N�g�;���Tn�&���q.p����D&� Fn�cu�(�v�4� �#,��dfW���>�'X`'����/�����y;�k/���}ƈ��T>P0�Rv? �2t��f���W�_.�vq�ǡ1h�7&b�x*;�0�������iO���t7l�#��kY����f�C�dv��~�
��5?I���+���*�]9n�{܉V,訲���K\�C��[C�}������7]p=��Cw���>U��������7_z籦��Ο���Ż�>x���Zp���_���e�@|�	O�y%��
_R)�a	�#%�_-��Bb�E��&<����?Fꝋ�8D�a�o��U�fA�i�������x���M|V��l�y� �s���g8qz��#��:��d~z��a�?^������Z��Po�Y�|���݌F���F2�1���D"E���U�*1�d$��HTϪ�ő��ۥƴ�6�-��ՖH����@BC��0��:a(�N1�*�o��X<�fu-V��(9fh:i)\6��̋6I�$4R7�V{X�m���k:�2����M�&�j�zG&=D{I��/?�W�+��y&OU�q��N�l<���R��
���^�{�B�-x�s2��g��y����5g7�9�$-�^}������u��2Y&�;5��M,�&�;A�W���p�(�_�2�ܓD~�8�s���;�1������^���8~����c��?����߃����:x���7���;�
O��#�O&m�\�?���OU׍c�pw���)�'�{聆t"��T���Ư�qx�yj�ُ�[�lMX����q%@�Ǔ�?�{םt���$�#
�=@�D���Iu:��>���Gb�ƳO}1=M��6�@��:�9�;��P�M�M=� ���J������q�-
��~
܏� �'�ۃ��m��:&^�v�_^���7`��s��[�c���L8{�s����ƒ�{��wN��9�i;��^����I)|������Q�`�֠:98���O�9Ŧ��yX����{ҙD�QvGYM�����~��nTi���v6O@0�_ �g�۬ݍЕ'��O�^3Ϸ�����o�$���EU��R��8��>W���-c�S��1 �{��vcu��8���W�Zv-b:8�k F������ms��.�D�c��k
�;I1)�=�rwa�&Z�}���PN��.��䐫�A[ȥ췇\�?u�]���®���]�@��ty���V����V�������>gfi�f	�?�?)�s�^�X^5��<o���|���|}t5㵬|�P���dO������z�s�p����?�˿ZƯ@f��,/�ςQ�����+��&�y}��Ҟn�?�dޟ�|-+����cEjf㺞�m�2�[ȧ9mhk[���dSFV�{Z<���,�|w�����_A�KP]�U�G|�h?�Y�HT�hN_\Ո�gĳH��ߊ^V=^�"�Y�GU��8����1��_C��]t�f�;`� �{��܎�sn'����O���>́�R�v�0�G�F�4G��?�(&H�?��_!��ņs��P�$�H�"�FZ�_is-r�H���p���Pe�����^��p�G��*�km� b�@�í�)�#���2��={wX��$ 2
aO�g���Kv�pC��I�qW<�Jh�ơ��yY#�����m�(5|�(�o+d>0�:t���Y�Rφ��(���;z��C�!��rmH!?x�Ȣ3eSz|(��Hن�}J������Mi놴���GA�d������0�4��1z[�H&mhQ#�A9W��H���A���Y�V�����D:b�Ko��C3�F�K7i$c�r�`E{y��� nd(�W��A�4�l�h0"CLJe=�x"��!"G�a䉍���F����2z<�2	*�e�D+����������F��x2i�!�ц��L$��ñL^�j$���Q~�+�!aD��(T�6���z�u䉦�I-�1m ;��s���xj0�+�h�����4~�[�M�"z_�޿�}`*/�%A^��{�}V*+��]�}����,���K>�w7����#�1��/Nd�͈�*���gx�R�
p�#��<cS��<?�g�|����"��p{�\�,��,���m���nf� ��9݁h�r{�O�0{�N��8~�`��}̞�sؾ���A��6@��5,��y*'q�'{��+�~����/{��9��_�m�A���߽,����G������d��78���}�{��}��i��$�?���B���s�� <�������u�=_��^��I?�W��r��o#:v�>�}����_n���?�����T�������=_�
3�_����m�S���/�q{�������_��)��Vs�T������_X¾�%�]Ba�����V�����J؟g�/�`�N��g�S��D���f�P1]d���/��MTG��MF�Ml�ζ�_�.�c�s��*E6�����sy����3n��fܑߛ��{܌�[�ؠW�-���Ԍ�ɽ'�x�w2�W��kf����-��<��ό�s�3^�{��y����{~������r�Æ��=G�����ф�x�wJ��Y����,��ה�����0|?��G�"^Eʊ�/�e�'�q�0���.�'n'������Ar]<�������WD�x>.Ѯ����+���IYrV�����|���.��W��O��Z��u�����#������J���d�]�[�>g������1LH��H���.��������K�F�>�pQ�>�`��뭕��O����'��������7����7|O�>���ۻ�����$P4c�FvpЃO9ll�Q;;���*ʟeP��Ňtd�j,�%���3�]�dGQ4��f-�i����ZI�om�Z�Ȍ!��&�c`R ���J6��~�6!ѯ�	v����v|����_������V�#�>�Ѿcs���ͬ�Oi�v�q/:��;�-��o�����ΐ��΁��gL��s���BO�
����.!�\��L'N������5O��Jgi�fi�f�� �/$ 4  