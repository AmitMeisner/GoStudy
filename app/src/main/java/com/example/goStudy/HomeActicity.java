package com.example.goStudy;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.SystemClock;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.aigestudio.wheelpicker.WheelPicker;
import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;
import com.google.firebase.auth.FirebaseAuth;
//import com.google.firebase.auth.FirebaseAuth;

import java.util.ArrayList;
import java.util.List;


public class HomeActicity extends AppCompatActivity {

    private boolean isResume;
    GoogleSignInClient mGoogleSignInClient;

    Chronometer chronometer;

    private boolean courseSelected = false;
//    private boolean resourceSelected = false;

    long tMiliSec, tStart, tBuff, tUpdate = 0L;
    int sec, min, millisec;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        setPracticeButton();
        setNavigationButtons();
        getGooglePersonalInformation();
        setSignOutButton();

//        CreateResourceSpinner();
        CreateChronometer();
        setSaveButton();

        /** Create choose courses and choose activity */
        Spinner courses_Spinner = findViewById(R.id.spr_courses);
        WheelPicker wheelPicker =(WheelPicker) findViewById(R.id.activity_wheel_picker);
        CreateCoursesSpinner(courses_Spinner, HomeActicity.this);
        setResourcesWheelPicker(wheelPicker, this);

    }

    public void setResourcesWheelPicker(WheelPicker wheelPicker , Context context) {
        List<String> data =new ArrayList<>();
        String[] activities = context.getResources().getStringArray(R.array.activities);
        for (String str : activities) {
            data.add(str);
        }
        wheelPicker.setData(data);
    }

    private void setSaveButton() {
        /** set snackbar when clicking SAVE */
        Button save = (Button) findViewById(R.id.saveBtn);
        ConstraintLayout suppl = findViewById(R.id.homeLayout);

        save.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Snackbar snackbar=Snackbar.make(suppl, R.string.activity_saved, Snackbar.LENGTH_LONG)
                        .setAction(R.string.editAct, new View.OnClickListener() {
                            @Override
                            public void onClick(View v) {

                                /** ADD HERE THE EDIT ACTION */
                            }
                        });
                snackbar.show();
            }
        });
    }


    private void CreateResourceSpinner() {
        Spinner resources_Spinner = findViewById(R.id.spr_resource);
        ArrayList<String> resources = new ArrayList<>();
        resources.add(0, "Choose Resource");
        resources.add("Homeworks");
        resources.add("Recitations");
        resources.add("Exams");
        resources.add("Tirgul");
        resources.add("Extra");
        ArrayAdapter<String> arrayAdapter_resources = new ArrayAdapter<String>(HomeActicity.this, android.R.layout.simple_spinner_item, resources);
        arrayAdapter_resources.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        resources_Spinner.setAdapter(arrayAdapter_resources);

        resources_Spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String text = (String) parent.getItemAtPosition(position);
                if (parent.getId() == R.id.spr_courses){
                    //prevent the timer to start if no course is chosen
                    courseSelected = text != "Choose Course";


                }
                //prevent the timer to start if no resource is chosen
//                else if (parent.getId()==R.id.spr_resource){
//                    resourceSelected = text != "Choose Resource";
//                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
    }

    public void CreateCoursesSpinner(Spinner courses_Spinner, Context context) {
        //create spinner courses
        WelcomeActivity wa = new WelcomeActivity();
        ArrayList<String> courses = wa.getUserCourses();
        ArrayAdapter<String> arrayAdapter_courses = new ArrayAdapter<String>(context, android.R.layout.simple_spinner_item, courses);
        arrayAdapter_courses.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        courses_Spinner.setAdapter(arrayAdapter_courses);
        courses_Spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            //prevent the timer to start if no course is chosen
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String text = (String) parent.getItemAtPosition(position);
                if (parent.getId() == R.id.spr_courses){
                    courseSelected = text != "Choose Course";

                }
                //prevent the timer to start if no source is chosen
//                else if (parent.getId()==R.id.spr_resource) {
//                    resourceSelected = text != "Choose Resource";
//                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

    }

    private void setSignOutButton() {
        Button signOut = findViewById(R.id.signOutBtn);
        signOut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                switch (v.getId()) {
                    case R.id.signOutBtn:
                        signOut();
                        break;
                }

            }
        });
    }

    private void getGooglePersonalInformation() {
        TextView usrName;
        GoogleSignInOptions gso;
        gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
                .requestEmail()
                .build();

        mGoogleSignInClient = GoogleSignIn.getClient(this, gso);

        GoogleSignInAccount acct = GoogleSignIn.getLastSignedInAccount(this);

        if (acct != null) {
            String personName = acct.getDisplayName();
            String personGivenName = acct.getGivenName();
            String personFamilyName = acct.getFamilyName();
            String personEmail = acct.getEmail();
            String personId = acct.getId();
            Uri personPhoto = acct.getPhotoUrl();
            usrName = findViewById(R.id.userName);
            usrName.setText("Hello "+personName);
        }
    }

    private void setNavigationButtons() {
        FloatingActionButton home= findViewById(R.id.HomeNav);
        FloatingActionButton stat= findViewById(R.id.statNav);
        FloatingActionButton tips= findViewById(R.id.TipsNav);
        FloatingActionButton progress= findViewById(R.id.progNav);

        home.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(HomeActicity.this, HomeActicity.class);
                startActivity(intent);
            }
        });

        stat.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(HomeActicity.this, StatActivity.class);
                startActivity(intent);
            }
        });

        tips.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(HomeActicity.this, TipsActivity.class);
                startActivity(intent);
            }
        });

        progress.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(HomeActicity.this, ProgressActivity.class);
                startActivity(intent);
            }
        });


    }

    /** Set Practice Button */
    private void setPracticeButton() {
        Button p=(Button) findViewById(R.id.practiceBtn);
        p.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent= new Intent(HomeActicity.this, Practice.class);
                startActivity(intent);
            }
        });
    }


    /** sign out from google and firebase accounts */
    private void signOut() {
        FirebaseAuth.getInstance().signOut();
        mGoogleSignInClient.signOut()
                .addOnCompleteListener(this, new OnCompleteListener<Void>() {
                    @Override
                    public void onComplete(@NonNull Task<Void> task) {
                        Intent intent = new Intent( HomeActicity.this , MainActivity.class);
                        startActivity(intent);
                        finish();
                    }
                });
    }


    private void CreateChronometer() {

//    ImageButton btStart, btStop,btManual;
        Handler handler_chronometer;


        chronometer = findViewById(R.id.chronometer);
        //btStart = root.findViewById(R.id.btn_start);
//        btManual = root.findViewById(R.id.btn_manual);
//        btStop = root.findViewById(R.id.btn_stop);
        handler_chronometer = new Handler();


        final Runnable runnable = new Runnable() {
            @Override
            public void run() {
                tMiliSec = SystemClock.uptimeMillis() - tStart;
                tUpdate = tBuff + tMiliSec;
                sec = (int) (tUpdate / 1000);
                min = sec / 60;
                sec = sec % 60;
                millisec = (int) (tUpdate % 100);
                chronometer.setText(String.format("%02d", min) + ":" + String.format("%02d", sec) + ":" + String.format("%02d", millisec));
                handler_chronometer.postDelayed(this, 60);
            }
        };

        /**
         //start the chronometer
         btStart.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {

        if (check_timer_options_validity()){
        hide_error_msg();
        if (!isResume) {                                                                                                                                             tStart = SystemClock.uptimeMillis();
        handler_chronometer.postDelayed(runnable, 0);
        chronometer.start();
        isResume = true;
        btStop.setVisibility(View.GONE);
        btStart.setImageDrawable(getResources().getDrawable(R.drawable.ic_pause));
        } else {
        tBuff += tMiliSec;
        handler_chronometer.removeCallbacks(runnable);
        chronometer.stop();
        isResume = false;
        btStop.setVisibility(View.VISIBLE);
        btStart.setImageDrawable(getResources().getDrawable(R.drawable.ic_play));
        }
        }else{
        show_error_msg();

        }
        }
        });
         */


        chronometer.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (check_timer_options_validity()){
                    //hide_error_msg();
                    if (!isResume) {
                        tStart = SystemClock.uptimeMillis();
                        handler_chronometer.postDelayed(runnable, 0);
                        chronometer.start();
                        isResume = true;
//                        btStop.setVisibility(View.GONE);
//                        btStart.setImageDrawable(getResources().getDrawable(R.drawable.ic_pause));
                    } else {
                        tBuff += tMiliSec;
                        handler_chronometer.removeCallbacks(runnable);
                        chronometer.stop();
                        isResume = false;
//                        btStop.setVisibility(View.VISIBLE);
//                        btStart.setImageDrawable(getResources().getDrawable(R.drawable.ic_play));
                    }
                }else{
                    show_error_msg();

                }
            }
        });
    }


    //prevent timer to run unless
    private boolean check_timer_options_validity(){
//        return resourceSelected != false && courseSelected != false;
        return courseSelected != false;
    }
    // if no course or resource is chosen send error msg
    private void show_error_msg(){
        Toast.makeText(HomeActicity.this, "choose a course and activity",Toast.LENGTH_LONG).show();
    }

//    private void hide_error_msg(){
//        TextView error_msg = static_root.findViewById(R.id.error_msg);
//        error_msg.setVisibility(View.INVISIBLE);
//    }

}


