package com.example.gostudy.ui.home;

import android.os.Bundle;
import android.os.Handler;
import android.os.SystemClock;
import android.view.LayoutInflater;
import android.view.View;
import java.util.ArrayList;
import java.util.List;
import android.view.ViewGroup;
import android.os.*;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import com.example.gostudy.R;

import java.util.ArrayList;

public class HomeFragment extends Fragment {
    Chronometer chronometer;
    ImageButton btStart, btStop;
    private boolean isResume;
    Handler handler_chronometer;
    long tMiliSec, tStart, tBuff, tUpdate = 0L;
    int sec, min, millisec;


    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        View root = inflater.inflate(R.layout.fragment_home, container, false);

        //create spinner courses
        Spinner courses_Spinner = root.findViewById(R.id.spr_courses);
        ArrayList<String> courses = new ArrayList<>();
        courses.add(0, "choose course");
        courses.add("Linear algebra 1");
        courses.add("Linear algebra 2");
        courses.add("Introduction into computer science");
        courses.add("Hedva 1");
        courses.add("Hedva 2");
        courses.add("Software project");
        ArrayAdapter<String> arrayAdapter_courses = new ArrayAdapter<String>(this.getActivity(), android.R.layout.simple_spinner_item, courses);
        arrayAdapter_courses.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        courses_Spinner.setAdapter(arrayAdapter_courses);

        //create spinner resource
        Spinner resources_Spinner = root.findViewById(R.id.spr_resource);
        ArrayList<String> resources = new ArrayList<>();
        resources.add(0, "choose resource");
        resources.add("Homeworks");
        resources.add("Recitations");
        resources.add("Exams");
        resources.add("Tirgul");
        resources.add("Extra");

        ArrayAdapter<String> arrayAdapter_resources = new ArrayAdapter<String>(this.getActivity(), android.R.layout.simple_spinner_item, resources);
        arrayAdapter_resources.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        resources_Spinner.setAdapter(arrayAdapter_resources);


        //create chronometer
        chronometer = root.findViewById(R.id.chronometer);
        btStart = root.findViewById(R.id.btn_start);
        btStop = root.findViewById(R.id.btn_stop);
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
        btStart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {                                                                                                                                         if (!isResume) {                                                                                                                                             tStart = SystemClock.uptimeMillis();
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
            }
        });


        btStop.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                if (!isResume) {
                    btStart.setImageDrawable(getResources().getDrawable(R.drawable.ic_play));
                    tMiliSec = 0L;
                    tStart = 0L;
                    tBuff = 0L;
                    tUpdate = 0L;
                    sec = 0;
                    min = 0;
                    millisec = 0;
                    chronometer.setText("00:00:00");
                }
            }
        });


        return root;

    }
}