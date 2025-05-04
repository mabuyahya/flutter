void main(List<String> arguments) async {
  print(func(1));
  print(await funcFuAsync(2));
  print(await funcFuValue(3));
}

int func(int i) {
  return (i + 1);
}

Future<int> funcFuAsync(int i) async {
  return (i + 1);

    }

Future<int> funcFuValue(int i) {
  return (Future.value(i + 1));
}
