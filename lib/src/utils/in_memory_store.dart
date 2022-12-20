import 'package:rxdart/subjects.dart';

class InMemoryStore<T> {
  //* an in_memory storage backed by BehaviourSubject that is used to store the data
  //* for all the fake repos in the app
  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);
  final BehaviorSubject<T> _subject;

  //* Output stream getter for listening stream
  Stream<T> get stream => _subject.stream;
  //* Getter to get value from stream
  T get value => _subject.value;

  //* Setter to add value to stream and in turn output stream will emit new value
  set value(T value)  => _subject.add(value);

  //* Call when done
  void close() => _subject.close();
}
