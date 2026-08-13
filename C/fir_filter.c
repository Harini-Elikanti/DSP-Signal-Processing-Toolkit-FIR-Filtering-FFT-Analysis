#include <stdio.h>
#include <math.h>

#define PI 3.141592653589793
#define FS 1000.0
#define N 1000
#define FILTER_ORDER 20
#define NUM_COEFF 21

int main()
{
    double signal[N];
    double filtered_signal[N];

    double f1 = 50.0;
    double f2 = 200.0;

    int n;
    int k;
    double t;

    /* FIR filter coefficients from MATLAB */
    double h[NUM_COEFF] = {
        -0.0000,
        -0.0021,
        -0.0063,
        -0.0116,
        -0.0124,
         0.0000,
         0.0318,
         0.0814,
         0.1375,
         0.1821,
         0.1992,
         0.1821,
         0.1375,
         0.0814,
         0.0318,
         0.0000,
        -0.0124,
        -0.0116,
        -0.0063,
        -0.0021,
        -0.0000
    };

    /* Generate input signal */
    for (n = 0; n < N; n++)
    {
        t = n / FS;

        signal[n] =
            sin(2 * PI * f1 * t)
            + 0.5 * sin(2 * PI * f2 * t);
    }

    /* FIR filtering */
    for (n = 0; n < N; n++)
    {
        filtered_signal[n] = 0.0;

        for (k = 0; k <= FILTER_ORDER; k++)
        {
            if (n >= k)
            {
                filtered_signal[n] +=
                    h[k] * signal[n - k];
            }
        }
    }

    /* Display first 10 filtered samples */
       /* Save filtered signal to CSV */

    FILE *file;

    file = fopen("E:\\DSP_toolkit\\results\\C_filtered_signal.csv", "w");

    if (file == NULL)
    {
        printf("Error opening output file!\n");
        return 1;
    }

    fprintf(file, "time,original,filtered\n");

    for (n = 0; n < N; n++)
    {
        fprintf(file, "%.6f,%.6f,%.6f\n",
                n / FS,
                signal[n],
                filtered_signal[n]);
    }

    fclose(file);

    printf("FIR filtering completed successfully.\n");
    printf("Results saved to Results/c_filtered_signal.csv\n");

    return 0;
}
