#ifndef SNAE_SOLVER_HXX
#define SNAE_SOLVER_HXX


#include "math_vector.hxx"
#define e 0.0000001


template <typename U = double>
class Simple_Iteration_Method
{
    public:
        Simple_Iteration_Method() = default;
        ~Simple_Iteration_Method() = default;

         Math_Vector<U> get_Solution(std::function<U(U)> f,
                                    const Math_Vector<U>& start_solution);
};

template <typename U>
Math_Vector<U> Simple_Iteration_Method<U>::get_Solution(std::function<U(U)> func,
                                                        const Math_Vector<U>& start_solution)
{
    const int vector_size = start_solution.size();
    double max_diff = 0;
    Math_Vector<U> curr_solution = start_solution;
    Math_Vector<U> prev_solution = start_solution;

    do
    {
        for(int i = 0; i < vector_size; i++)
        {
            curr_solution[i] = func(curr_solution[i]);
        }
        max_diff = std::abs(Math_Abs(curr_solution[0]) - Math_Abs(prev_solution[0]));
        for(int i = 1; i < vector_size; i++)
        {
            const double difference = std::abs(Math_Abs(curr_solution[i]) - Math_Abs(prev_solution[i]));;
            if(difference > max_diff)
            {
                max_diff = difference;
            }
        }
        prev_solution = curr_solution;
    }while(max_diff > e);
    return curr_solution;
}

#endif // SNAE_SOLVER_HXX
