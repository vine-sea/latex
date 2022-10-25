kitty : dialog{
    : row{
    : column{
        : edit_box  {
            label="k_c1";
            edit_width=5;
            fixed_width=true;
            key=k_c1;
            action="(setq k_c1  (atof (get_tile \"k_c1\"))  )";
        }
        : edit_box  {
            label="k_c2";
            edit_width=5;
            fixed_width=true;
            key=k_c2;
            action="(setq k_c2  (atof (get_tile \"k_c2\"))  )";
        }
        : edit_box  {
            label="k_c3";
            edit_width=5;
            fixed_width=true;
            key=k_c3;
            action="(setq k_c3  (atof (get_tile \"k_c3\"))  )";
        }
        : edit_box  {
            label="k_c4";
            edit_width=5;
            fixed_width=true;
            key=k_c4;
            action="(setq k_c4  (atof (get_tile \"k_c4\")) )";
        }
        : edit_box  {
            label="k_c5";
            edit_width=5;
            fixed_width=true;
            key=k_c5;
            action="(setq k_c5  (atof (get_tile \"k_c5\")) )";
        }
        : edit_box  {
            label="k_c6";
            edit_width=5;
            fixed_width=true;
            key=k_c6;
            action="(setq k_c6  (atof (get_tile \"k_c6\")) )";
        }
        : edit_box  {
            label="k_c7";
            edit_width=5;
            fixed_width=true;
            key=k_c7;
            action="(setq k_c7  (atof (get_tile \"k_c7\")) )";
        }

        spacer_1;

        : edit_box  {
            label="k_t1";
            edit_width=10;
            fixed_width=true;
            key=k_t1;
            action="(setq k_t1 (get_tile \"k_t1\"))";
        }
        : edit_box  {
            label="k_t2";
            edit_width=10;
            fixed_width=true;
            key=k_t2;
            action="(setq k_t2 (get_tile \"k_t2\"))";
        }
        : edit_box  {
            label="k_t3";
            edit_width=10;
            fixed_width=true;
            key=k_t3;
            action="(setq k_t3 (get_tile \"k_t3\"))";
        }
        : edit_box  {
            label="k_t4";
            edit_width=10;
            fixed_width=true;
            key=k_t4;
            action="(setq k_t4 (get_tile \"k_t4\"))";
        }
        : edit_box  {
            label="k_t5";
            edit_width=10;
            fixed_width=true;
            key=k_t5;
            action="(setq k_t5 (get_tile \"k_t5\"))";
        }
        : edit_box  {
            label="k_t6";
            edit_width=10;
            fixed_width=true;
            key=k_t6;
            action="(setq k_t6 (get_tile \"k_t6\"))";
        }
        : edit_box  {
            label="k_t7";
            edit_width=10;
            fixed_width=true;
            key=k_t7;
            action="(setq k_t7 (get_tile \"k_t7\"))";
        }
  
 


    }
    : column{
        
  
     
    : row {
        : column {
            :radio_button{
                label="Hide_obj";
                key="k_r1";
                action="(setq std2 1)";
            }
            :radio_button{
                label="Show_obj";
                key="k_r2";
                action="(setq std2 2 )";
            }
            :radio_button{
                label="Hide_lay";
                key="k_r3";
                action="(setq std2 3 )";
            }
            :radio_button{
                label="Show_lay";
                key="k_r4";
                action="(setq std2 4 )";
            }
            :radio_button{
                label="Scale";
                key="k_r5";
                action="(setq std2 5 )";
            }
            :radio_button{
                label="Load All";
                key="k_r6";
                action="(setq std2 6 )";
            }
            :radio_button{
                label="Pu";
                key="k_r7";
                action="(setq std2 7 )";
            }
            :radio_button{
                label="2w";
                key="k_r8";
                action="(setq std2 8 )";
            }
            :radio_button{
                label="mlex";
                key="k_r9";
                action="(setq std2 9 )";
            }
            :radio_button{
                label="sortLable";
                key="k_r10";
                action="(setq std2 10 )";
            }
            :radio_button{
                label="pipe";
                key="k_r11";
                action="(setq std2 11 )";
            }
            :radio_button{
                label="2";
                key="k_r12";
                action="(setq std2 12 )";
            }

        }    

        : column {
            :radio_button{
                label="3";
                key="k_r13";
                action="(setq std2 13)";
            }
            :radio_button{
                label="midli";
                key="k_r14";
                action="(setq std2 14 )";
            }
            :radio_button{
                label="32";
                key="k_r15";
                action="(setq std2 15 )";
            }
            :radio_button{
                label="ca";
                key="k_r16";
                action="(setq std2 16 )";
            }
            :radio_button{
                label="q";
                key="k_r17";
                action="(setq std2 17 )";
            }
            :radio_button{
                label="lineT";
                key="k_r18";
                action="(setq std2 18 )";
            }
            :radio_button{
                label="d1";
                key="k_r19";
                action="(setq std2 19 )";
            }
            :radio_button{
                label="d2s";
                key="k_r20";
                action="(setq std2 20 )";
            }
            :radio_button{
                label="brex";
                key="k_r21";
                action="(setq std2 21 )";
            }
            :radio_button{
                label="noff";
                key="k_r22";
                action="(setq std2 22 )";
            }
            :radio_button{
                label="xx";
                key="k_r23";
                action="(setq std2 23 )";
            }
            :radio_button{
                label="xx";
                key="k_r24";
                action="(setq std2 24 )";
            }
        }   

    }
               


               





     
   
        
        
        None;
        : popup_list{

            key="k_l1";
            action="(setq k_l1  (atof (get_tile \"k_l1\")) )";
        }


    }


    }



}






None : button {
    label = "None(&N)";
    fixed_width = true;
    is_cancel=true;
    is_default=true;
    key  = "cancel";
    mnemonic="N";
    action="(done_dialog 0)";
}