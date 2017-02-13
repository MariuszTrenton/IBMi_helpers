// ----------------------------------------------                                                  
       //                                                                                                   
       //   Mariusz Andrzejczak 02/2017                                                                     
       //                                                                                                   
       //   Body for GET_IFS                                                                            
       //     *** DB2 service for IFS listing                                                               
       //     Returns objects from specified IFS folder                                                     
       //     along with set of basic attributes.                                                                 
       //                                                                                                   
       //    My response for RFE ID : 90136
       // ----------------------------------------------                                                    
       ctl-opt dftactgrp(*no) actgrp(*caller);                                                              
       //                                                                                                   
       dcl-pr get_ifs extpgm;                                                                               
              path varchar(256) const;                                                                      
              objectname varchar(256);                                                                      
              object varchar(512);                                                                          
              type varchar(11);                                                                             
              size int(20);                                                                                 
              ccsid int(5);                                                                                 
              accessed timestamp;                                                                           
              content_modified timestamp;                                                                   
              status_modified timestamp;                                                                    
              owner char(11);                                                                               
              n_path int(5) const;                                                                          
              n_objectname int(5);                                                                          
              n_object int(5);                                                                              
              n_type int(5);                                                                                
              n_size int(5);                                                                                
              n_ccsid int(5);                                                                               
              n_accessed int(5);                                                                            
              n_content_modified int(5);                                                                    
              n_status_modified int(5);                                                                     
              n_owner int(5);                                                                               
              SQLSTT char(5);                                                                               
              function varchar(517) const;                                                                  
              specific varchar(128) const;                                                                  
              error_msg varchar(70);                                                                        
              call_type int(10) const;                                                                      
       end-pr;                                                                                              
       dcl-pi get_ifs ;                                                                                     
              path varchar(256) const;                                                                      
              objectname varchar(256);                                                                      
              object varchar(512);                                                                          
              type varchar(11);                                                                             
              size int(20);                                                                                 
              ccsid int(5);                                                                                 
              accessed timestamp;                                                                           
              content_modified timestamp;                                                                   
              status_modified timestamp;                                                                    
              owner char(11);                                                                               
              n_path int(5) const;                                                                          
              n_objectname int(5);                                                                          
              n_object int(5);                                                                              
              n_type int(5);                                                                                
              n_size int(5);                                                                                
              n_ccsid int(5);                                                                               
              n_accessed int(5);                                                                            
              n_content_modified int(5);                                                                    
              n_status_modified int(5);                                                                     
              n_owner int(5);                                                                               
              SQLSTT char(5);                                                                               
              function varchar(517) const;                                                                  
              specific varchar(128) const;                                                                  
              error_msg varchar(70);                                                                        
              call_type int(10) const;                                                                      
       end-pi;                                                                                              
       dcl-pr opendir pointer extproc('opendir');                                                           
          path pointer value   options(*string:*trim);                                                      
       end-pr;                                                                                              
       //                                                                                                   
       dcl-pr readdir pointer extproc('readdir');                                                           
          path pointer value;                                                                               
       end-pr;                                                                                              
                                                                                                            
       dcl-pr closedir int(10) extproc('closedir');                                                         
          path pointer value;                                                                               
       end-pr;                                                                                              
       dcl-pr lstat64 int(10) extproc('lstat64');                                                           
          path pointer value options(*string);                                                              
          buffer likeds(stat64_ds);                                                                         
       end-pr;                                                                                              
       dcl-pr getpwuid pointer extproc('getpwuid');                                                         
          uid uns(10) value;                                                                                
       end-pr;                                                                                              
       dcl-pr errno pointer extproc('__errno');                                                             
       end-pr;                                                                                              
       dcl-pr strerror  pointer  extProc('strerror');                                                       
         errnum  int(10) value;                                                                             
       end-pr;                                                                                              
       dcl-pr doOpen;                                                                                       
          ipath varchar(256) const;                                                                         
       end-pr;                                                                                              
       dcl-pr doFetch;                                                                                      
          ipath varchar(256) const;                                                                         
       end-pr;                                                                                              
       dcl-pr doClose;                                                                                      
       end-pr;                                                                                              
       // standalones & consts                                                                              
       dcl-s   errno_c  int(10) based(p_errno);                                                             
       dcl-s   rc int(10);                                                                                  
       dcl-s   pOpen pointer;                                                                               
       dcl-s   path_norm varchar(256);                                                                      
       dcl-s   sysbirth timestamp;                                                                          
       dcl-c   call_open const(-1);                                                                         
       dcl-c   call_fetch const(0);                                                                         
       dcl-c   call_close const(1);                                                                         
       dcl-c   null_parm const(-1);                                                                         
       dcl-c   notnull_parm const(0);                                                                       
       // response structure for readdir                                                                    
       dcl-ds rde_ds based(pentry);                                                                         
         osize uns(5) pos(55) ;                                                                             
         oname char(600) pos(57);                                                                           
       end-ds ;                                                                                             
       //response structure for lstat64                                                                     
       dcl-ds stat64_ds ;                                                                                   
         st_mode   uns(10);                                                                                 
         st_ino    uns(10);                                                                                 
         st_uid    uns(10);                                                                                 
         st_gid    uns(10);                                                                                 
         st_size   int(20);                                                                                 
         st_atime  int(10);                                                                                 
         st_mtime  int(10);                                                                                 
         st_ctime  int(10);                                                                                 
         st_dev    uns(10);                                                                                 
         st_blksize  uns(10);                                                                               
         st_nlink    uns(5);                                                                                
         st_codepage  uns(5);                                                                               
         st_allocsize   uns(20);                                                                            
         st_ino_gen_id   uns(10);                                                                           
         st_objtype  char(11);                                                                              
         st_reserved2 char(5);                                                                              
         st_rdev  uns(10);                                                                                  
         st_rdev64   uns(20);                                                                               
         st_dev64  uns(20);                                                                                 
         st_nlink32   uns(10);                                                                              
         st_reserved1 char(26);                                                                             
         st_ccsid    uns(5);                                                                                
       end-ds;                                                                                              
       dcl-ds passwd based(puser);                                                                          
         pw_name pointer;                                                                                   
         pw_uid  uns(10);                                                                                   
         pw_gid  uns(10);                                                                                   
         pw_dir  pointer;                                                                                   
         pw_shell pointer;                                                                                  
       end-ds;                                                                                              
       //                                                                                                   
        if n_path=null_parm;                                                                                
           sqlStt='39998';                                                                                  
           error_msg='Wrong path specified.';                                                               
        endif;                                                                                              
        select;                                                                                             
          when call_type=call_open;                                                                         
               doOpen(path);                                                                                
          when call_type=call_fetch;                                                                        
               doFetch(path_norm);                                                                          
          when call_type=call_close;                                                                        
               doClose();                                                                                   
         endsl;                                                                                             
         return;                                                                                            
        // --------------------------------------                                                           
        //                                                                                                  
        // --------------------------------------                                                           
        dcl-proc doOpen;                                                                                    
           dcl-pi *n ;                                                                                      
             ipath varchar(256) const;                                                                      
           end-pi;                                                                                          
             pOpen=opendir(ipath);                                                                          
             if pOpen=*NULL;                                                                                
                sqlStt='39998';                                                                             
                error_msg='Wrong path specified.';                                                          
             endif;                                                                                         
             if %subst(%trim(ipath):(%len(%trim(ipath))-1):1)<>'/';                                         
                path_norm=%trim(ipath)+'/';                                                                 
             endif;                                                                                         
             sysbirth=%timestamp('1970-01-01-00.00.00.000000');                                             
        end-proc;                                                                                           
        // --------------------------------------                                                           
        //                                                                                                  
        // --------------------------------------                                                           
        dcl-proc doFetch;                                                                                   
           dcl-pi *n ;                                                                                      
             ipath varchar(256) const;                                                                      
           end-pi;                                                                                          
           dcl-s en char(128);                                                                              
           dcl-s rc int(10);                                                                                
           dou (%subst(rde_ds.oname:1:rde_ds.osize)<>'.'                                                    
               and %subst(rde_ds.oname:1:rde_ds.osize)<>'..');                                              
               pEntry=readdir(pOpen);                                                                       
               if pEntry<>*NULL;                                                                            
                  objectname = %subst(rde_ds.oname:1:rde_ds.osize);                                         
                  n_objectname = notnull_parm;                                                              
                  object = %trim(path_norm)+%trim(objectname);                                              
                  if lstat64(object:stat64_ds)>=0;                                                          
                     size = st_size;                                                                        
                     n_size = notnull_parm;                                                                 
                     ccsid=st_ccsid;                                                                        
                     n_ccsid= notnull_parm;                                                                 
                     accessed = sysbirth+%seconds(st_atime);                                                
                     n_accessed = notnull_parm;                                                             
                     content_modified = sysbirth+%seconds(st_mtime);                                        
                     n_content_modified = notnull_parm;                                                     
                     status_modified = sysbirth+%seconds(st_ctime);                                         
                     n_status_modified = notnull_parm;                                                      
                     type = st_objtype;                                                                     
                     n_type = notnull_parm;                                                                 
                     puser = getpwuid(st_uid);                                                              
                     if puser=*null;                                                                        
                        owner='n/a';                                                                        
                     else;                                                                                  
                        owner=%str(pw_name);                                                                
                     endif;                                                                                 
                     n_owner = notnull_parm;                                                                
                  else;                                                                                     
                     p_errno = errno();                                                                     
                     en = %str(strerror(errno_c));                                                          
                     n_size = null_parm;                                                                    
                     n_accessed = null_parm;                                                                
                     n_content_modified = null_parm;                                                        
                     n_status_modified = null_parm;                                                         
                     n_type = null_parm;                                                                    
                                                                                                            
                  endif;                                                                                    
                else;                                                                                       
                  sqlStt='02000';                                                                           
                  return;                                                                                   
               endif;                                                                                       
           enddo;                                                                                           
                                                                                                            
        end-proc;                                                                                           
        // --------------------------------------                                                           
        //                                                                                                  
        // --------------------------------------                                                           
         dcl-proc doClose;                                                                                  
           dcl-pi *n;                                                                                       
           end-pi;                                                                                          
             closedir(pOpen);                                                                               
             return;                                                                                        
         end-proc;    
