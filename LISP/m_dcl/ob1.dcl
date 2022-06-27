 

 

d2 : dialog {
    label = "Tool";
    : column{

        : row {
            part2;
            part1;
            
             
        }

 
        spacer_1; 
        // ok_only;
        kitty;
       
       
    }

}




test1 : dialog {
    spacer_1;
    kitty1;
}


test2 : dialog {

    spacer_1;
    kitty2;
}









kitty : row{     
        alignment =left;
        fixed_width = true;
        Sure;
        None;
}      

kitty1 : row{     
        alignment =left;
        fixed_width = true;
        label="test1";
        : button{
            label="t2";
            key="m_t1";
            action="(mgta \"test2\" '(700 200) )";
        }

        : button{
            label="xxx";
            is_cancel=true;
        }

         
}     

kitty2 : row{     
        alignment =left;
        fixed_width = true;
        label="test2";
        : button{
            label="t1";
            key="m_t2";
            action="(mgta \"test1\" '(700 400) )";
        }

        : button{
            label="xxx";
            is_cancel=true;
        }


         
}   




Sure : button {
    fixed_width = true;
    label = "En(&N)";
 

    key  = "accept";
    mnemonic="N";
    // action="(mdata ) (m_getData )";
    // alignment = right ;//centered;
    // vertical_alignment = centered;
    // horizontal_alignment = centered;
}


None : button {
    fixed_width = true;
    label = "En(&E)";
     
    is_cancel=true;
    is_default=true;
    key  = "cancel";
    mnemonic="E";

   
}
 

pick_cancel : column {
    : row {
        fixed_width = true;
        alignment = centered;
        : button {
            label = "Pau(&P) <";
            key = "accept";
            is_default = true;
        }
        : spacer { width = 1; }
        cancel_button;
        : spacer { width = 1; }
        help_button;
    }
}


part1 : column{
    
    part11;
    part12;
    

    : slider{
        key="m_sl";
        value=50; 
        max_value=0;
        min_value=100;

        }

}


part11  : column{
        label="Num";
         
        children_fixed_width=true;
        children_alignment=left;
     
        : edit_box{
            
            label="off             ";
            edit_width=5;
            key="y1";
            action="(mdata )";
            // value=100;
            
        }
        : edit_box{
            label="vertical length ";
            edit_width=5;
            key="y2";
            action="(mdata )";
            // value=100;
        }
   



        : edit_box{
            label="vertical or not  ";
            edit_width=5;
            key="y3";
            action="(mdata )";
            // value=100;
        }
        : edit_box{
            label="scale            ";
            edit_width=5; 
            key="y4";
            action="(mdata )";
            // value=100;
        }
        : edit_box{
            label="changedim        ";
            edit_width=5;
            key="y5";
            action="(mdata )";
            // value=100;
        }
        : edit_box{
            label="XXX              ";
            edit_width=5;
            key="y6";
            action="(mdata )";           
            // value=100;
        }
        
}
 
// ����
part12 : column{
        label="button";
        
        : row {
            fixed_width=true;
            alignment=centered;
            : button{
                label="`12";
                key="buf1";
                action="(mdata ) (done_dialog 3)";
                
            }

            : button{
                label="`44";
                key="buf2";
                action="(mdata ) (done_dialog 4)";
                
            }

            : button{
                label="ucs Re";
                key="buf3";
                action="(mdata ) (done_dialog 5)";
            }

        }
        : row {
            fixed_width=true;
            alignment=centered;
            : button{
                label="412";
                key="buf4";
                action="(mdata ) (done_dialog 6)";
            }

            : button{
                label="24";
                key="buf5";
                action="(mdata ) (done_dialog 7)";
            }

            : button{
                label="showObj";
                key="buf6";
                action="(mdata ) (done_dialog 8)";
            }



        }
        : row {
            fixed_width=true;
            alignment=centered;
            : button{
                label="hideObj";
                key="buf7";
                action="(mdata ) (done_dialog 9)";
            }
            : button{
                label="load all";
                key="buf8";
                action="(mdata ) (done_dialog 10)";
            }
            : button{
                label="scale";
                key="buf9";
                action="(mdata ) (done_dialog 11)";
            }


        }

        : row {
            fixed_width=true;
            alignment=centered;
            : button{
                label="layoff";
                key="buf10";
                action="(mdata ) (done_dialog 12)";
            }
            : button{
                label="layon";
                key="buf11";
                action="(mdata ) (done_dialog 13)";
            }
            : button{
                label="PU(&Q)";
                key="buf12";
                mnemonic="Q";
                action="(mdata ) (done_dialog 14)";
            }


        }
    

}


part2 : column{

    label="m_list";
  
    : list_box{
        fixed_height = true;
        // label="layer2";
        key="m_lays2";
        fixed_width=true;
        action="(mdata ) ";
    }
    spacer_0;
    : image{
        alignment=centered;
        vertical_margin = none;
        horizontal_margin = none;
        fixed_height = true;
        fixed_width = true;
        height = 9;
        width = 12;
        key="blockImage";
        
        color=250;
    }
    spacer_0;
    : popup_list{
        is_default=true;
        key="m_lays";
        action="(mdata ) (m_setBlockImage ) ";
        
    }



}


// d1_c
d1 : dialog {

    children_alignment = centered;
    : row {
        
 
        // list
        : column {
        children_alignment = top;
        : popup_list{
         
            key="d1_l1";
            action="(setq d1_l1  (atof (get_tile \"d1_l1\")) m_lays2 (atof (get_tile \"d1_l1\")))";
        }
        :radio_column {
            :radio_button{
                label="Hide_obj";
                key="d1_r1";
                action="(setq std2 1)";
            }
            :radio_button{
                label="Show_obj";
                key="d1_r2";
                action="(setq std2 2 )";
            }
            :radio_button{
                label="Hide_lay";
                key="d1_r3";
                action="(setq std2 3 )";
            }
            :radio_button{
                label="Show_lay";
                key="d1_r4";
                action="(setq std2 4 )";
            }
            :radio_button{
                label="Scale";
                key="d1_r5";
                action="(setq std2 5 )";
            }
            :radio_button{
                label="Load All";
                key="d1_r6";
                action="(setq std2 6 )";
            }
            :radio_button{
                label="Pu";
                key="d1_r7";
                action="(setq std2 7 )";
            }

        }



        }
            
        // editbox
        : column  {


 
            // �r�Ŧ���Ʀr
            : edit_box  {
                label="d1_c1";
                edit_width=5;
                fixed_width=true;
                key=d1_c1;
                action="(setq d1_c1  (atof (get_tile \"d1_c1\")) y1  (atof (get_tile \"d1_c1\")))";
            }
            : edit_box  {
                label="d1_c2";
                edit_width=5;
                fixed_width=true;
                key=d1_c2;
                action="(setq d1_c2  (atof (get_tile \"d1_c2\")) y2  (atof (get_tile \"d1_c2\")))";
            }
            : edit_box  {
                label="d1_c3";
                edit_width=5;
                fixed_width=true;
                key=d1_c3;
                action="(setq d1_c3  (atof (get_tile \"d1_c3\")) y3  (atof (get_tile \"d1_c3\")))";
            }
            : edit_box  {
                label="d1_c4";
                edit_width=5;
                fixed_width=true;
                key=d1_c4;
                action="(setq d1_c4  (atof (get_tile \"d1_c4\")) v_scale  (atof (get_tile \"d1_c4\")))";
            }
            : edit_box  {
                label="d1_c5";
                edit_width=5;
                fixed_width=true;
                key=d1_c5;
                action="(setq d1_c5  (atof (get_tile \"d1_c5\")) )";
            }


            // �r�Ŧ�
            : edit_box  {
                label="d1_c6";
                edit_width=5;
                fixed_width=true;
                key=d1_c6;
                action="(setq d1_c6 (get_tile \"d1_c6\") m_str   (get_tile \"d1_c6\"))";
            }
            : edit_box  {
                label="d1_c7";
                edit_width=5;
                fixed_width=true;
                key=d1_c7;
                action="(setq d1_c7 (get_tile \"d1_c7\"))";
            }
            : edit_box  {
                label="d1_c8";
                edit_width=5;
                fixed_width=true;
                key=d1_c8;
                action="(setq d1_c8 (get_tile \"d1_c8\"))";
            }
            : edit_box  {
                label="d1_c9";
                edit_width=5;
                fixed_width=true;
                key=d1_c9;
                // action="(setq d1_c9 (get_tile \"d1_c9\"))";
                action="(setq d1_c9  (atof (get_tile \"d1_c9\")) )";
            }
            : edit_box  {
                label="d1_c10";
                edit_width=4;
                fixed_width=true;
                key=d1_c10;
                // action="(setq d1_c10 (get_tile \"d1_c10\"))";
                action="(setq d1_c10  (atof (get_tile \"d1_c10\")) )";
            }


        }


        // button
        : column{
            : button{
                label="`12   (d1_b1)";
                key="d1_b1";
                
                action="(done_dialog 1)";
                
            }
            : button{
                label="Reucs   (d1_b2)";
                key="d1_b2";
                action="(done_dialog 2)";
            }
            : button{
                label="412   (d1_b3)";
                key="d1_b3";
                action="(done_dialog 3)";
                
            }
            : button{
                label="24   (d1_b4)";
                key="d1_b4";
                action="(done_dialog 4)";  
                
            }
            : button{
                label="bus   (d1_b5)";
                key="d1_b5";
                is_default=true;
                action="(done_dialog 5)";
                
            }
            : button{
                label="d1_b6";
                key="d1_b6";
                action="(done_dialog 6)";
                
            }
            : button{
                label="d1_b7";
                key="d1_b7";
                action="(done_dialog 7)";
                
            }
            : button{
                label="d1_b8";
                key="d1_b8";
                action="(done_dialog 8)";
                
            }
            : button{
                label="d1_b9";
                key="d1_b9";
                action="(done_dialog 9)";
                
            }
            : button{
                label="d1_b10";
                key="d1_b10";
                action="(done_dialog 10)";
                
            }
        }

        // button
        : column{
            : button{
                label="d1_b11";
                key="d1_b11";
                action="(done_dialog 11)";
                
            }
            : button{
                label="d1_b12";
                key="d1_b12";
                action="(done_dialog 12)";
                
            }
            : button{
                label="d1_b13";
                key="d1_b13";
                action="(done_dialog 13)";
                
            }
            : button{
                label="d1_b14";
                key="d1_b14";
                action="(done_dialog 14)";
                
            }
            : button{
                label="d1_b15";
                key="d1_b15";
                action="(done_dialog 15)";
                
            }
            : button{
                label="d1_b16";
                key="d1_b16";
                action="(done_dialog 16)";
                
            }
            : button{
                label="d1_b17";
                key="d1_b17";
                action="(done_dialog 17)";
                
            }
            : button{
                label="d1_b18";
                key="d1_b18";
                action="(done_dialog 18)";
                
            }
            : button{
                label="d1_b19";
                key="d1_b19";
                action="(done_dialog 19)";
                
            }
            : button{
                label="d1_b20";
                key="d1_b20";
                action="(done_dialog 20)";
                
            }
        }


    }


    : column{
        children_alignment = left;
        : button{
                label="done";
                fixed_width=true;
                is_cancel=true;
                action="(done_dialog 0)";
        }
    }



}



 

 